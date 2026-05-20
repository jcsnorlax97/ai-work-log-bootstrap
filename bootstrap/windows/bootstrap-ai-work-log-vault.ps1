param(
    [string]$VaultRoot = (Join-Path $env:USERPROFILE "Documents\a-ai-obsidian-vaults\ai-work-logs")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\..")).Path

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "created: $Path"
    }
}

function Copy-IfMissing {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path -LiteralPath $Destination) {
        Write-Host "skip existing: $Destination"
        return
    }

    Copy-Item -LiteralPath $Source -Destination $Destination
    Write-Host "created: $Destination"
}

$Today = Get-Date
$Year = $Today.ToString("yyyy")
$Month = $Today.ToString("MM")
$Day = $Today.ToString("dd")

Ensure-Directory (Join-Path $VaultRoot "inbox\$Year\$Month\$Day\conversations")
Ensure-Directory (Join-Path $VaultRoot "inbox\$Year\$Month\$Day\notes")
Ensure-Directory (Join-Path $VaultRoot "inbox\$Year\$Month\$Day\automations")
Ensure-Directory (Join-Path $VaultRoot "generated")
Ensure-Directory (Join-Path $VaultRoot "templates")
Ensure-Directory (Join-Path $VaultRoot "hooks")

Copy-IfMissing (Join-Path $RepoRoot "templates\vault-README.md") (Join-Path $VaultRoot "README.md")
Copy-IfMissing (Join-Path $RepoRoot "templates\inbox-README.md") (Join-Path $VaultRoot "inbox\README.md")
Copy-IfMissing (Join-Path $RepoRoot "templates\generated-README.md") (Join-Path $VaultRoot "generated\README.md")
Copy-IfMissing (Join-Path $RepoRoot "bootstrap\templates\work-log-vault.gitignore") (Join-Path $VaultRoot ".gitignore")

Get-ChildItem -LiteralPath (Join-Path $RepoRoot "templates") -File | ForEach-Object {
    if ($_.Name -notin @("vault-README.md", "inbox-README.md", "generated-README.md")) {
        Copy-IfMissing $_.FullName (Join-Path $VaultRoot ("templates\" + $_.Name))
    }
}

Copy-IfMissing (Join-Path $RepoRoot "hooks\capture_session_end.py") (Join-Path $VaultRoot "hooks\capture_session_end.py")

Write-Host ""
Write-Host "AI work-log vault initialized at:"
Write-Host $VaultRoot
Write-Host ""
Write-Host "Example:"
Write-Host "Use `$capture-work-session to capture this session into $VaultRoot."
