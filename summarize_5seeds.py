import pandas as pd
import os

base = r'D:\PerturbCO\FrontierCO-main\FrontierCO-main\data\CVRP'
seeds = [0, 1, 42, 123, 2024]
all_dfs = []

for s in seeds:
    csv_path = os.path.join(base, f'baseline_30s_s{s}', 'summary_results.csv')
    df = pd.read_csv(csv_path)
    df['seed'] = s
    df['size'] = df['Instance'].str.extract(r'_(\d+)_').astype(int)
    all_dfs.append(df)

combined = pd.concat(all_dfs, ignore_index=True)
combined['Objective'] = pd.to_numeric(combined['Objective'], errors='coerce')

print('=== 按规模汇总（5个seed的均值±标准差）===')
for size in [20, 50, 100]:
    sub = combined[combined['size'] == size]
    mean_obj = sub['Objective'].mean()
    std_obj = sub['Objective'].std()
    mean_time = sub['Runtime'].mean()
    print(f'{size}节点: 目标值={mean_obj:.2f} ± {std_obj:.2f}, 平均耗时={mean_time:.1f}s, 样本数={len(sub)}')

print()
print('=== 每个seed的平均目标值 ===')
for s in seeds:
    sub = combined[combined['seed'] == s]
    m20 = sub[sub['size']==20]['Objective'].mean()
    m50 = sub[sub['size']==50]['Objective'].mean()
    m100 = sub[sub['size']==100]['Objective'].mean()
    print(f'seed={s}: 总均={sub["Objective"].mean():.2f} (20={m20:.2f}, 50={m50:.2f}, 100={m100:.2f})')

print()
print('=== 跨seed变异系数(CV=std/mean) ===')
for size in [20, 50, 100]:
    sub = combined[combined['size'] == size]
    cv = sub['Objective'].std() / sub['Objective'].mean() * 100
    print(f'{size}节点: CV={cv:.3f}%')
