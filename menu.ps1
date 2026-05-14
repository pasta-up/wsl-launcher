function wsl {
    $distros = & wsl.exe --list --quiet | ForEach-Object {
        $_.Trim()
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
    $choice = Read-Host "Select distro number"

    if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $distros.Count) {
        $selected = $distros[[int]$choice - 1]
        & wsl.exe -d $selected
    } else {
        Write-Host "Invalid selection."
    }
}