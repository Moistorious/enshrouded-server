$ErrorActionPreference = "Stop"

$Registry = "docker-registry.devon.page"
$ImageName = "enshrouded-server"
$ImageTag = "latest"
$FullImage = "$Registry/$ImageName`:$ImageTag"

Write-Host "Logging into $Registry..."
docker login $Registry

Write-Host "Building image $FullImage..."
docker build -t $FullImage .

Write-Host "Pushing $FullImage..."
docker push $FullImage

Write-Host "Deployed $FullImage successfully"
