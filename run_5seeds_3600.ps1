$seeds = @(0, 1, 42, 123, 2024)
$venvPython = "D:\PerturbCO\.venv\Scripts\python.exe"
$solveScript = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP\solve.py"
$workDir = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP"

Set-Location $workDir

foreach ($seed in $seeds) {
    $outputDir = "baseline_3600s_s$seed"
    $logFile = "hgs_3600s_s${seed}.log"
    Write-Host "=== Running seed=$seed, time_limit=3600s, output=$outputDir ==="
    & $venvPython $solveScript --dir instances --output $outputDir --time_limit 3600 --threads 0 --seed $seed --batch_size 1 *> $logFile
    Write-Host "=== seed=$seed done, log saved to $logFile ==="
}
Write-Host "All 5 runs completed!"
