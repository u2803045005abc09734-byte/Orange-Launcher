use crate::{LauncherError, LauncherResult};
use oneclient_common::paths;
use oneclient_net::RequestClient;
use oneclient_net::{EtagPolicy, fetch_cached};

const CHANGELOG_URL: Option<&str> = option_env!("ORANGE_CLIENT_CHANGELOG_URL");

#[derive(Debug, Clone, PartialEq, Eq, serde::Deserialize)]
pub struct ChangelogEntry {
    pub version: String,
    pub body: String,
}

#[tracing::instrument(level = "debug", skip(net))]
pub async fn fetch_changelog(net: &RequestClient) -> LauncherResult<Vec<ChangelogEntry>> {
    let Some(url) = CHANGELOG_URL.filter(|url| !url.trim().is_empty()) else {
        return Ok(Vec::new());
    };
    let cache_path = paths::caches_dir()?.join("changelog.json");

    let fetched = fetch_cached(net, url, &cache_path, EtagPolicy::CommitNow)
        .await?
        .ok_or_else(|| LauncherError::InvalidSettingsProfile {
            reason: "changelog is unavailable and not cached".to_string(),
        })?;

    Ok(fetched.json()?)
}
