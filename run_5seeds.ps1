$seeds = @(1, 123, 2024, 0)
$venvPython = "D:\PerturbCO\.venv\Scripts\python.exe"
$solveScript = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP\solve.py"
$workDir = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP"

Set-Location $workDir

foreach ($seed in $seeds) {
    $outputDir = "baseline_30s_s$seed"
    Write-Host "=== Running seed=$seed, output=$outputDir ==="
    & $venvPython $solveScript --dir instances --output $outputDir --time_limit 30 --threads 0 --seed $seed --batch_size 1
    Write-Host "=== seed=$seed done ==="
}
Write-Host "All 4 runs completed!"
