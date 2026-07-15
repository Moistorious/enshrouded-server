$ErrorActionPreference = "Stop"

$Registry = "docker-registry.devon.page"
$ImageName = "enshrouded-server"
$ImageTag = "latest"
$FullImage = "$Registry/$ImageName`:$ImageTag"

Write-Host "Fixing line endings in entrypoint.sh..."
$bytes = [System.IO.File]::ReadAllBytes("$PSScriptRoot\entrypoint.sh")
$content = [System.Text.Encoding]::UTF8.GetString($bytes) -replace "`r`n", "`n"
[System.IO.File]::WriteAllBytes("$PSScriptRoot\entrypoint.sh", [System.Text.Encoding]::UTF8.GetBytes($content))

Write-Host "Logging into $Registry..."
docker login $Registry

Write-Host "Building image $FullImage..."
docker build -t $FullImage .

Write-Host "Pushing $FullImage..."
docker push $FullImage

Write-Host "Deployed $FullImage successfully"
