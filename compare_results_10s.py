import pandas as pd
import os

base = r'D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP'

def load(name):
    df = pd.read_csv(os.path.join(base, name, 'summary_results.csv'))
    df['Objective'] = pd.to_numeric(df['Objective'], errors='coerce')
    return df

def compare(set_name, base_dir, pert_dir):
    b = load(base_dir).set_index('Instance')
    p = load(pert_dir).set_index('Instance')
    merged = b[['Objective','Vehicles']].join(p[['Objective','Vehicles']], lsuffix='_base', rsuffix='_pert')
    merged['diff'] = merged['Objective_pert'] - merged['Objective_base']
    merged['improve_pct'] = -merged['diff'] / merged['Objective_base'] * 100
    print(f'===== {set_name} =====')
    print(f'{"Instance":<18}{"Baseline":>12}{"Perturb":>12}{"Diff":>10}{"Improve%":>10}')
    for inst, row in merged.iterrows():
        print(f'{inst:<18}{row["Objective_base"]:>12.2f}{row["Objective_pert"]:>12.2f}{row["diff"]:>10.2f}{row["improve_pct"]:>9.2f}%')
    print(f'{"MEAN":<18}{merged["Objective_base"].mean():>12.2f}{merged["Objective_pert"].mean():>12.2f}{merged["diff"].mean():>10.2f}{merged["improve_pct"].mean():>9.2f}%')
    wins = (merged['diff'] < -1e-6).sum()
    ties = (merged['diff'].abs() <= 1e-6).sum()
    losses = (merged['diff'] > 1e-6).sum()
    print(f'Perturb better: {wins}, tie: {ties}, worse: {losses}')
    print()
    return merged

compare('EASY (Golden) 10s perturb=0.1', 'easy_baseline_10s', 'easy_perturb_01_10s')
compare('VALID 10s perturb=0.1', 'valid_baseline_10s', 'valid_perturb_01_10s')
