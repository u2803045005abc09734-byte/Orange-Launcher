fn main() {
    #[cfg(windows)]
    {
        let mut res = winresource::WindowsResource::new();
        res.set_icon("icons/icon.ico");

        let version = env!("CARGO_PKG_VERSION");
        res.set("CompanyName", "Orange Client Community");
        res.set("ProductName", "Orange Client");
        res.set("FileDescription", "Orange Client Minecraft Launcher");
        res.set("LegalCopyright", "© 2023-2026 Polyfrost contributors; Orange Client fork modifications © 2026");
        res.set("OriginalFilename", "orange-client.exe");
        res.set("InternalName", "orange-client");
        res.set("FileVersion", version);
        res.set("ProductVersion", version);

        res.compile()
            .expect("failed to embed Windows icon resource");
    }
}
