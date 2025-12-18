"""
Data Utilities for Dashboard
Shared functions for data cleaning, formatting, and display
"""

import pandas as pd
import streamlit as st
from typing import List, Dict, Optional


def clean_for_charts(df: pd.DataFrame, required_cols: List[str]) -> pd.DataFrame:
    """
    Remove rows with NaN in required columns for charting
    
    Args:
        df: DataFrame to clean
        required_cols: Columns that must have non-NaN values
    
    Returns:
        Cleaned DataFrame
    """
    return df.dropna(subset=required_cols)


def normalize_sectors(df: pd.DataFrame) -> pd.DataFrame:
    """
    Standardize sector display to prevent mixing broad/specific categories
    
    Converts:
    - "Software" (subcategory) → "Software"
    - "Technology" (no subcategory) → "Technology (General)"
    
    Args:
        df: DataFrame with 'primary_sector' and optionally 'sub_sector' columns
    
    Returns:
        DataFrame with 'display_sector' column added
    """
    def get_display_sector(row):
        if pd.notna(row.get('sub_sector')) and row['sub_sector'] != '':
            return row['sub_sector']
        elif pd.notna(row.get('primary_sector')):
            return f"{row['primary_sector']} (General)"
        return "Uncategorized"
    
    df['display_sector'] = df.apply(get_display_sector, axis=1)
    return df


def add_percentage_formatting(value: float) -> str:
    """Format number as percentage"""
    if pd.notna(value):
        return f"{value:.1f}%"
    return "-"


def get_column_config() -> Dict[str, st.column_config.Column]:
    """
    Standard column configuration for Streamlit dataframes
    Adds proper units and formatting
    
    Returns:
        Dictionary of column configs
    """
    return {
        # Percentages
        'Board Independence %': st.column_config.NumberColumn(
            'Board Independence (%)',
            help="Percentage of independent directors",
            format="%.0f%%"
        ),
        'Board Diversity %': st.column_config.NumberColumn(
            'Board Diversity (%)',
            help="Gender and ethnic diversity", 
            format="%.0f%%"
        ),
        'Say-on-Pay %': st.column_config.NumberColumn(
            'Say-on-Pay Support (%)',
            help="Shareholder approval percentage",
            format="%.1f%%"
        ),
        
        # Ratios
        'CEO Pay Ratio': st.column_config.TextColumn(
            'CEO Pay Ratio (×)',
            help="CEO to median employee pay ratio"
        ),
        
        # Counts
        'Total Patents': st.column_config.NumberColumn(
            'Total Patents',
            help="Patent count",
            format="%d"
        ),
        'Overboarded Directors': st.column_config.NumberColumn(
            'Overboarded',
            help="Directors on too many boards",
            format="%d"
        ),
        'AI Risk Mentions': st.column_config.NumberColumn(
            'AI Risk Mentions',
            help="Count in 10-K Risk Factors",
            format="%d"
        ),
        'Climate Risk Mentions': st.column_config.NumberColumn(
            'Climate Mentions',
            help="Count in 10-K Risk Factors",
            format="%d"
        ),
        
        # Scores
        'innovation_score': st.column_config.NumberColumn(
            'Innovation Score',
            help="Composite score (0-100)",
            format="%.1f"
        ),
        'governance_score': st.column_config.NumberColumn(
            'Governance Score',
            help="Composite score (0-100)",
            format="%.1f"
        )
    }


def safe_mean(series: pd.Series) -> Optional[float]:
    """Calculate mean, handling NaN values"""
    clean = series.dropna()
    if len(clean) > 0:
        return clean.mean()
    return None


def format_large_number(num: float) -> str:
    """Format large numbers with K/M/B suffix"""
    if pd.isna(num):
        return "-"
    
    if abs(num) >= 1_000_000_000:
        return f"${num/1_000_000_000:.1f}B"
    elif abs(num) >= 1_000_000:
        return f"${num/1_000_000:.1f}M"
    elif abs(num) >= 1_000:
        return f"${num/1_000:.1f}K"
    else:
        return f"${num:.0f}"
