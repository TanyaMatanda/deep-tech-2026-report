# Chart Data Quality Fixes

## Issue: Sector categorization mixing broad and specific categories

**Problem**: Charts show "Technology" alongside "Software", "Hardware", causing:
- Statistical bias (broad category aggregates many subcategories)
- Misleading comparisons
- Empty/sparse visualizations

**Solution**: Standardize sector groupings

### Option 1: Use Sub-Sectors Only
```python
# Filter out companies with only broad "Technology" sector
df_cleaned = df[df['sub_sector'].notna()]  # Only include specific subcategories
```

### Option 2: Normalize Broad Categories
```python
def normalize_sector(row):
    """Map broad categories to most common subcategory or 'Other'"""
    if row['primary_sector'] == 'Technology' and pd.isna(row['sub_sector']):
        return 'Technology - Other'
    return row['sub_sector'] if pd.notna(row['sub_sector']) else row['primary_sector']

df['sector_normalized'] = df.apply(normalize_sector, axis=1)
```

### Option 3: Aggregate to Broad Categories
```python
# Use only primary_sector, ignore subcategories for consistency
df_aggregated = df.groupby('primary_sector').agg({
    'metric': 'mean'
}).reset_index()
```

## Recommended Fix for Bubble Charts

```python
# Before
sector_stats = private_df.groupby('primary_sector').agg({
    'patents_count': 'sum',
    'innovation_score': 'mean',
    'company_name': 'count'
}).reset_index()

# After - Use sub_sector with fallback
def get_display_sector(row):
    if pd.notna(row.get('sub_sector')) and row['sub_sector'] != '':
        return row['sub_sector']
    elif pd.notna(row.get('primary_sector')):
        return f"{row['primary_sector']} (General)"
    return "Uncategorized"

private_df['display_sector'] = private_df.apply(get_display_sector, axis=1)

sector_stats = private_df.groupby('display_sector').agg({
    'patents_count': 'sum',
    'innovation_score': 'mean',
    'company_name': 'count'
}).reset_index()
```

This ensures:
- ✅ Consistent granularity (all specific subcategories OR all broad)
- ✅ No statistical bias from mixing levels
- ✅ Clear labeling "(General)" for companies without subcategory
- ✅ Better visual distribution in charts
