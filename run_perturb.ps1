$venvPython = "D:\PerturbCO\.venv\Scripts\python.exe"
$workDir = "D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP"
Set-Location $workDir

Write-Host "=== [1/2] Perturb easy_test_instances ==="
& $venvPython "solve - perturb.py" --dir download/easy_test_instances --output easy_perturb_001_60s --time_limit 60 --threads 0 --seed 42 --batch_size 1
Write-Host "=== easy done ==="

Write-Host "=== [2/2] Perturb valid_instances ==="
& $venvPython "solve - perturb.py" --dir download/valid_instances --output valid_perturb_001_60s --time_limit 60 --threads 0 --seed 42 --batch_size 1
Write-Host "=== valid done ==="

Write-Host "All perturbation runs completed!"
