$venvPython = "D:\PerturbCO\.venv\Scripts\python.exe"
$workDir = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP"
Set-Location $workDir

Write-Host "=== [1/2] BASELINE hard 10s ==="
& $venvPython "solve.py" --dir download/hard_test_instances --output hard_baseline_10s --time_limit 10 --threads 0 --seed 42 --batch_size 1
Write-Host "=== hard baseline done ==="

Write-Host "=== [2/2] PERTURB(0.1) hard 10s ==="
& $venvPython "solve - perturb.py" --dir download/hard_test_instances --output hard_perturb_01_10s --time_limit 10 --threads 0 --seed 42 --batch_size 1
Write-Host "=== hard perturb done ==="

Write-Host "HARD RUNS COMPLETED!"
