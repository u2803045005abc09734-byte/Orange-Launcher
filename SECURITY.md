# Security Policy

## Supported versions

Security fixes are applied to the current version of Orange Client. Older downloads may not receive fixes.

## Reporting a vulnerability

Please do not publish exploit details, credentials, access tokens, or private user data in a public issue.

Use GitHub's **Report a vulnerability** feature on this repository to send a private vulnerability report. Include the affected version, steps to reproduce, and impact where possible.

## Local account data

On Windows, current Orange Client builds encrypt the local account file with Windows DPAPI and migrate older plaintext account files on first launch. This protects saved tokens at rest for the Windows user account that created them. It does not protect against malware already running as that user. Non-Windows builds do not yet have this protection.

## Download integrity

Official CI builds publish SHA-256 checksums alongside the Windows executable and installer. Compare a downloaded file with the corresponding checksum before running it.

A checksum confirms file integrity relative to the published checksum; it does not by itself prove that a file is harmless or publisher-authentic.
