$venvPython = "D:\PerturbCO\.venv\Scripts\python.exe"
$workDir = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP"
Set-Location $workDir

Write-Host "=== [1/4] BASELINE easy_test_instances ==="
& $venvPython "solve.py" --dir download/easy_test_instances --output easy_baseline_60s --time_limit 60 --threads 0 --seed 42 --batch_size 1
Write-Host "=== easy baseline done ==="

Write-Host "=== [2/4] BASELINE valid_instances ==="
& $venvPython "solve.py" --dir download/valid_instances --output valid_baseline_60s --time_limit 60 --threads 0 --seed 42 --batch_size 1
Write-Host "=== valid baseline done ==="

Write-Host "=== [3/4] PERTURB(0.05) easy_test_instances ==="
& $venvPython "solve - perturb.py" --dir download/easy_test_instances --output easy_perturb_005_60s --time_limit 60 --threads 0 --seed 42 --batch_size 1
Write-Host "=== easy perturb done ==="

Write-Host "=== [4/4] PERTURB(0.05) valid_instances ==="
& $venvPython "solve - perturb.py" --dir download/valid_instances --output valid_perturb_005_60s --time_limit 60 --threads 0 --seed 42 --batch_size 1
Write-Host "=== valid perturb done ==="

Write-Host "ALL 4 RUNS COMPLETED!"
