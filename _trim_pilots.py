import csv, re

def read_csv_all(filepath):
    with open(filepath, encoding='utf-8-sig', newline='') as f:
        return list(csv.reader(f))

def write_csv(filepath, rows):
    with open(filepath, 'w', encoding='utf-8-sig', newline='') as f:
        writer = csv.writer(f)
        writer.writerows(rows)

def r_name(csv_name):
    """Convert a CSV column name to what R's read.csv() would produce."""
    # R replaces non-alphanumeric chars (except . and _) with dots
    rn = re.sub(r'[^A-Za-z0-9._]', '.', csv_name)
    # If starts with a digit, X is prepended
    if rn and rn[0].isdigit():
        rn = 'X' + rn
    # Collapse consecutive dots
    rn = re.sub(r'\.{2,}', '.', rn)
    return rn

# ── P1 required R-names ──
P1_R_KEEP = {
    'StartDate',
    'DistributionChannel', 'Q1', 'Finished',
    'X110.Rules_111', 'X110.Rules_112', 'X110.Rules_113',
    'X110.Rules_114', 'X110.Rules_115', 'X110.Rules_116', 'X110.Rules_117',
    'Services',
    'Religiosity', 'Moral.Source._13',
    'Gender', 'God', 'Political_party',
    'Age', 'SES', 'Political_overall',
    'Income', 'Education',
}
P1_R_PREFIXES = ('Race_Ethnicity_', 'Faith_')

# ── P2 required R-names ──
P2_R_KEEP = {
    'StartDate',
    'DistributionChannel', 'Q1', 'Finished',
    'Religiosity', 'Q115_15',
    'Gender', 'God', 'Political_party',
    'Age', 'SES', 'Political_overall',
    'Income', 'Education',
}
P2_R_PREFIXES = ('Race_Ethnicity_', 'Faith_')

def should_keep(r_colname, keep_set, prefixes):
    if r_colname in keep_set:
        return True
    for p in prefixes:
        if r_colname.startswith(p):
            return True
    return False

def process(filepath, keep_set, prefixes):
    rows = read_csv_all(filepath)
    headers = rows[0]
    r_headers = [r_name(h) for h in headers]
    
    keep_indices = []
    kept = []
    dropped = []
    for i, (csv_name, rn) in enumerate(zip(headers, r_headers)):
        if should_keep(rn, keep_set, prefixes):
            keep_indices.append(i)
            kept.append(f'{csv_name} -> {rn}')
        else:
            dropped.append(f'{csv_name} -> {rn}')
    
    result = open(filepath.replace('.csv', '_trim_log.txt'), 'w', encoding='utf-8')
    result.write(f'{filepath}: {len(headers)} -> {len(keep_indices)} columns\n\n')
    result.write('KEPT:\n')
    for k in kept:
        result.write(f'  {k}\n')
    result.write(f'\nDROPPED ({len(dropped)}):\n')
    for d in dropped:
        result.write(f'  {d}\n')
    result.close()
    
    # Check all required found
    found_r = set(r_headers[i] for i in keep_indices)
    for name in keep_set:
        if name not in found_r:
            print(f'  WARNING: {name} not found!')
    
    trimmed = [[row[i] for i in keep_indices] for row in rows]
    write_csv(filepath, trimmed)
    print(f'{filepath}: {len(headers)} -> {len(trimmed[0])} columns, {len(trimmed)} rows')

# Re-read from archive originals first
import shutil
import os

archive = 'Data Collection/archive'
for fn in os.listdir(archive):
    if not fn.endswith('.csv'):
        continue
    path = os.path.join(archive, fn)
    with open(path, encoding='utf-8-sig') as f:
        row1 = next(csv.reader(f))
    ncols = len(row1)
    # P1 has 268 cols, P2 has 200 cols (from earlier)
    if ncols == 268:
        print(f'Restoring P1 from archive: {fn}')
        shutil.copy2(path, 'Data Collection/P1.csv')
    elif ncols == 200:
        print(f'Restoring P2 from archive: {fn}')
        shutil.copy2(path, 'Data Collection/P2.csv')

process('Data Collection/P1.csv', P1_R_KEEP, P1_R_PREFIXES)
process('Data Collection/P2.csv', P2_R_KEEP, P2_R_PREFIXES)
