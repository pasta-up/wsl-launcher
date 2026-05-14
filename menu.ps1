function wsl {
    $distros = & wsl.exe --list --quiet | ForEach-Object {
        $_.Trim()
    } | Where-Object {
        $_ -ne ""
    }

    function Show-WslMenu {
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

    if ($args.Count -eq 1 -and $args[0] -match '^\d+$') {
        $index = [int]$args[0]

        if ($index -ge 1 -and $index -le $distros.Count) {
            $selected = $distros[$index - 1]
            & wsl.exe -d $selected
            return
        }

        Show-WslMenu
        return
    }

    if ($args.Count -gt 0) {
        & wsl.exe @args
        return
    }

    Show-WslMenu
}