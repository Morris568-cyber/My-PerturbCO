$venvPython = "D:\PerturbCO\.venv\Scripts\python.exe"
$workDir = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP"
Set-Location $workDir

Write-Host "=== [1/4] BASELINE easy 10s ==="
& $venvPython "solve.py" --dir download/easy_test_instances --output easy_baseline_10s --time_limit 10 --threads 0 --seed 42 --batch_size 1
Write-Host "=== easy baseline done ==="

Write-Host "=== [2/4] BASELINE valid 10s ==="
& $venvPython "solve.py" --dir download/valid_instances --output valid_baseline_10s --time_limit 10 --threads 0 --seed 42 --batch_size 1
Write-Host "=== valid baseline done ==="

Write-Host "=== [3/4] PERTURB(0.1) easy 10s ==="
& $venvPython "solve - perturb.py" --dir download/easy_test_instances --output easy_perturb_01_10s --time_limit 10 --threads 0 --seed 42 --batch_size 1
Write-Host "=== easy perturb done ==="

Write-Host "=== [4/4] PERTURB(0.1) valid 10s ==="
& $venvPython "solve - perturb.py" --dir download/valid_instances --output valid_perturb_01_10s --time_limit 10 --threads 0 --seed 42 --batch_size 1
Write-Host "=== valid perturb done ==="

Write-Host "ALL 4 RUNS COMPLETED!"
