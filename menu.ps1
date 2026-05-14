function wsl {
    $distros = & wsl.exe --list --quiet | ForEach-Object {
    ($_ -replace "`0", "").Trim()
    } | Where-Object {
    $_ -ne ""
    }

    if ($args.Count -gt 0) {
        & wsl.exe @args
        return
    }

    Write-Host ""
    Write-Host "Installed WSL instances:"
    Write-Host ""

    for ($i = 0; $i -lt $distros.Count; $i++) {
        Write-Host "[$($i + 1)] $($distros[$i])"
    }

    Write-Host ""
    Write-Host "[Q] Quit"
    Write-Host ""

    $choice = Read-Host "Select distro number"

    if ($choice -match '^[Qq]$') {
        Write-Host "Cancelled."
        return
    }

    if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $distros.Count) {
        $selected = $distros[[int]$choice - 1]
        & wsl.exe -d $selected
    } else {
        Write-Host "Invalid selection."
    }
}