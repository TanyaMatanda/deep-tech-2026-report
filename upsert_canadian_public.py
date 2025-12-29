
import os
from supabase import create_client, Client, ClientOptions
import toml

# Configuration
try:
    secrets = toml.load(".streamlit/secrets.toml")
    url = secrets["SUPABASE_URL"]
    key = secrets["SUPABASE_KEY"]
except Exception:
    try:
        secrets = toml.load("dashboard/.streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
    except:
        url = os.getenv("SUPABASE_URL")
        key = os.getenv("SUPABASE_KEY")

if not url or not key:
    print("❌ Error: Supabase credentials not found.")
    exit(1)

options = ClientOptions(schema='vendor_governance')
supabase: Client = create_client(url, key, options=options)

def upsert_companies():
    print("Upserting Canadian Public Companies...")
    
    companies = [
        # TSX Technology
        {'name': 'Adcore Inc.', 'ticker': 'ADCO', 'exchange': 'TSX'},
        {'name': 'Alithya Group Inc.', 'ticker': 'ALYA', 'exchange': 'TSX'},
        {'name': 'Altus Group Limited', 'ticker': 'AIF', 'exchange': 'TSX'},
        {'name': 'Baylin Technologies Inc.', 'ticker': 'BYL', 'exchange': 'TSX'},
        {'name': 'BBTV Holdings Inc.', 'ticker': 'BBTV', 'exchange': 'TSX'},
        {'name': 'Bitfarms Ltd.', 'ticker': 'BITF', 'exchange': 'TSX'},
        {'name': 'BlackBerry Limited', 'ticker': 'BB', 'exchange': 'TSX'},
        {'name': 'Blackline Safety Corp.', 'ticker': 'BLN', 'exchange': 'TSX'},
        {'name': 'Bragg Gaming Group Inc.', 'ticker': 'BRAG', 'exchange': 'TSX'},
        {'name': 'CAE Inc.', 'ticker': 'CAE', 'exchange': 'TSX'},
        {'name': 'Calian Group Ltd.', 'ticker': 'CGY', 'exchange': 'TSX'},
        {'name': 'Celestica Inc.', 'ticker': 'CLS', 'exchange': 'TSX'},
        {'name': 'Ceridian HCM Holding Inc.', 'ticker': 'CDAY', 'exchange': 'TSX'},
        {'name': 'CGI Inc.', 'ticker': 'GIB', 'exchange': 'TSX'},
        {'name': 'Computer Modelling Group Ltd.', 'ticker': 'CMG', 'exchange': 'TSX'},
        {'name': 'Constellation Software Inc.', 'ticker': 'CSU', 'exchange': 'TSX'},
        {'name': 'Converge Technology Solutions Corp.', 'ticker': 'CTS', 'exchange': 'TSX'},
        {'name': 'Copperleaf Technologies Inc.', 'ticker': 'CPLF', 'exchange': 'TSX'},
        {'name': 'Coveo Solutions Inc.', 'ticker': 'CVO', 'exchange': 'TSX'},
        {'name': 'CubicFarm Systems Corp.', 'ticker': 'CUB', 'exchange': 'TSX'},
        {'name': 'CyberCatch Holdings Inc.', 'ticker': 'CYBE', 'exchange': 'TSX'},
        {'name': 'D2L Inc.', 'ticker': 'DTOL', 'exchange': 'TSX'},
        {'name': 'Dayforce Inc.', 'ticker': 'DAY', 'exchange': 'TSX'},
        {'name': 'Descartes Systems Group Inc.', 'ticker': 'DSG', 'exchange': 'TSX'},
        {'name': 'D-Box Technologies Inc.', 'ticker': 'DBO', 'exchange': 'TSX'},
        {'name': 'Docebo Inc.', 'ticker': 'DCBO', 'exchange': 'TSX'},
        {'name': 'Dye & Durham Limited', 'ticker': 'DND', 'exchange': 'TSX'},
        {'name': 'East Side Games Group Inc.', 'ticker': 'EAGR', 'exchange': 'TSX'},
        {'name': 'Enghouse Systems Limited', 'ticker': 'ENGH', 'exchange': 'TSX'},
        {'name': 'Enthusiast Gaming Holdings Inc.', 'ticker': 'EGLX', 'exchange': 'TSX'},
        {'name': 'Evertz Technologies Limited', 'ticker': 'ET', 'exchange': 'TSX'},
        {'name': 'Firan Technology Group Corporation', 'ticker': 'FTG', 'exchange': 'TSX'},
        {'name': 'Givex Corp.', 'ticker': 'GIVX', 'exchange': 'TSX'},
        {'name': 'Haivision Systems Inc.', 'ticker': 'HAI', 'exchange': 'TSX'},
        {'name': 'Hut 8 Mining Corp.', 'ticker': 'HUT', 'exchange': 'TSX'},
        {'name': 'illumin Holdings Inc.', 'ticker': 'ILLM', 'exchange': 'TSX'},
        {'name': 'Information Services Corporation', 'ticker': 'ISV', 'exchange': 'TSX'},
        {'name': 'Intermap Technologies Corporation', 'ticker': 'IMP', 'exchange': 'TSX'},
        {'name': 'Kinaxis Inc.', 'ticker': 'KXS', 'exchange': 'TSX'},
        {'name': 'kneat.com, inc.', 'ticker': 'KSI', 'exchange': 'TSX'},
        {'name': 'Lightspeed Commerce Inc.', 'ticker': 'LSPD', 'exchange': 'TSX'},
        {'name': 'Lumine Group Inc.', 'ticker': 'LMN', 'exchange': 'TSX'},
        {'name': 'MDA Ltd.', 'ticker': 'MDA', 'exchange': 'TSX'},
        {'name': 'mdf commerce inc.', 'ticker': 'MDF', 'exchange': 'TSX'},
        {'name': 'MediaValet Inc.', 'ticker': 'MVP', 'exchange': 'TSX'},
        {'name': 'Nuvei Corporation', 'ticker': 'NVEI', 'exchange': 'TSX'},
        {'name': 'NXT Energy Solutions Inc.', 'ticker': 'SFD', 'exchange': 'TSX'},
        {'name': 'Open Text Corporation', 'ticker': 'OTEX', 'exchange': 'TSX'},
        {'name': 'Opsens Inc.', 'ticker': 'OPS', 'exchange': 'TSX'},
        {'name': 'Optiva Inc.', 'ticker': 'OPT', 'exchange': 'TSX'},
        {'name': 'Payfare Inc.', 'ticker': 'PAY', 'exchange': 'TSX'},
        {'name': 'Propel Holdings Inc.', 'ticker': 'PRL', 'exchange': 'TSX'},
        {'name': 'Q4 Inc.', 'ticker': 'QFOR', 'exchange': 'TSX'},
        {'name': 'Quarterhill Inc.', 'ticker': 'QTRH', 'exchange': 'TSX'},
        {'name': 'Quantum Emotion Corp.', 'ticker': 'QNC', 'exchange': 'TSX'},
        {'name': 'Shopify Inc.', 'ticker': 'SHOP', 'exchange': 'TSX'},
        {'name': 'Telesat Corp', 'ticker': 'TSAT', 'exchange': 'TSX'},
        {'name': 'Topicus.com Inc.', 'ticker': 'TOI', 'exchange': 'TSX'},
        {'name': 'Tucows Inc.', 'ticker': 'TC', 'exchange': 'TSX'},
        
        # TSX Venture
        {'name': '01 Communique Laboratory Inc.', 'ticker': 'ONE', 'exchange': 'TSX-V'},
        {'name': 'A2Z Smart Technologies Corp.', 'ticker': 'AZ', 'exchange': 'TSX-V'},
        {'name': 'Acceleware Ltd.', 'ticker': 'AXE', 'exchange': 'TSX-V'},
        {'name': 'Ackroo Inc.', 'ticker': 'AKR', 'exchange': 'TSX-V'},
        {'name': 'AdRabbit Limited', 'ticker': 'RABI', 'exchange': 'TSX-V'},
        {'name': 'Advent-AWI Holdings Inc.', 'ticker': 'AWI', 'exchange': 'TSX-V'},
        {'name': 'AGEDB Technology Ltd.', 'ticker': 'AGET', 'exchange': 'TSX-V'},
        {'name': 'AirIQ Inc.', 'ticker': 'IQ', 'exchange': 'TSX-V'},
        {'name': 'Aisix Solutions Inc.', 'ticker': 'AISX', 'exchange': 'TSX-V'},
        {'name': 'Alphinat Inc.', 'ticker': 'NPA', 'exchange': 'TSX-V'},
        {'name': 'AnalytixInsight Inc.', 'ticker': 'ALY', 'exchange': 'TSX-V'},
        {'name': 'ARHT Media Inc.', 'ticker': 'ART', 'exchange': 'TSX-V'},
        {'name': 'Armada Data Corporation', 'ticker': 'ARD', 'exchange': 'TSX-V'},
        {'name': 'Astron Connect Inc.', 'ticker': 'AST', 'exchange': 'TSX-V'},
        {'name': 'ATW Tech Inc.', 'ticker': 'ATW', 'exchange': 'TSX-V'},
        {'name': 'Avante Corp.', 'ticker': 'XX', 'exchange': 'TSX-V'},
        {'name': 'Axion Ventures Inc.', 'ticker': 'AXV', 'exchange': 'TSX-V'},
        {'name': 'Backstageplay Inc.', 'ticker': 'BP', 'exchange': 'TSX-V'},
        {'name': 'Banxa Holdings Inc.', 'ticker': 'BNXA', 'exchange': 'TSX-V'},
        {'name': 'BEACN Wizardry & Magic Inc.', 'ticker': 'BECN', 'exchange': 'TSX-V'},
        {'name': 'BeWhere Holdings Inc.', 'ticker': 'BEW', 'exchange': 'TSX-V'},
        {'name': 'Bitcoin Well Inc.', 'ticker': 'BTCW', 'exchange': 'TSX-V'},
        {'name': 'Black Swan Graphene Inc.', 'ticker': 'SWAN', 'exchange': 'TSX-V'},
        {'name': 'BlockchainK2 Corp.', 'ticker': 'BITK', 'exchange': 'TSX-V'},
        {'name': 'Blockmate Ventures Inc.', 'ticker': 'MATE', 'exchange': 'TSX-V'},
        {'name': 'BlockMint Technologies Inc.', 'ticker': 'BKMT', 'exchange': 'TSX-V'},
        {'name': 'BlueRush Inc.', 'ticker': 'BTV', 'exchange': 'TSX-V'},
        {'name': 'Boardwalktech Software Corp.', 'ticker': 'BWLK', 'exchange': 'TSX-V'},
        {'name': 'Builddirect.com Technologies Inc.', 'ticker': 'BILD', 'exchange': 'TSX-V'},
        {'name': 'Carbeeza Inc.', 'ticker': 'AUTO', 'exchange': 'TSX-V'},
        {'name': 'Carebook Technologies Inc.', 'ticker': 'CRBK', 'exchange': 'TSX-V'},
        {'name': 'Cathedra Bitcoin Inc.', 'ticker': 'CBIT', 'exchange': 'TSX-V'},
        {'name': 'C-Com Satellite Systems Inc.', 'ticker': 'CMI', 'exchange': 'TSX-V'},
        {'name': 'CE Brands Inc.', 'ticker': 'CEBI', 'exchange': 'TSX-V'},
        {'name': 'Champion Gaming Group Inc.', 'ticker': 'WAGR', 'exchange': 'TSX-V'},
        {'name': 'Clip Money Inc.', 'ticker': 'CLIP', 'exchange': 'TSX-V'},
        {'name': 'CloudMD Software & Services Inc.', 'ticker': 'DOC', 'exchange': 'TSX-V'},
        {'name': 'Contagious Gaming Inc.', 'ticker': 'CNS', 'exchange': 'TSX-V'},
        {'name': 'Cryptostar Corp.', 'ticker': 'CSTR', 'exchange': 'TSX-V'},
        {'name': 'DelphX Capital Markets Inc.', 'ticker': 'DELX', 'exchange': 'TSX-V'},
        {'name': 'Destiny Media Technologies Inc.', 'ticker': 'DSY', 'exchange': 'TSX-V'},
        {'name': 'Enablence Technologies', 'ticker': 'ENA', 'exchange': 'TSX-V'},
        {'name': 'EQ Inc.', 'ticker': 'EQ', 'exchange': 'TSX-V'},
        {'name': 'Kraken Robotics Inc.', 'ticker': 'PNG', 'exchange': 'TSX-V'},
        {'name': 'LQWD Technologies Corp.', 'ticker': 'LQWD', 'exchange': 'TSX-V'},
        {'name': 'Matador Technologies Inc.', 'ticker': 'MATA', 'exchange': 'TSX-V'},
        {'name': 'Metavista3D Inc.', 'ticker': 'DDD', 'exchange': 'TSX-V'},
        {'name': 'Nubeva Technologies', 'ticker': 'NBVA', 'exchange': 'TSX-V'},
        {'name': 'Quisitive Technology Solutions', 'ticker': 'QUIS', 'exchange': 'TSX-V'},
        {'name': 'SSC Security Services', 'ticker': 'SECU', 'exchange': 'TSX-V'},
        {'name': 'Zoomd Technologies Ltd.', 'ticker': 'ZOMD', 'exchange': 'TSX-V'}
    ]
    
    for co in companies:
        try:
            # Check if exists by name
            existing = supabase.table("companies").select("id").eq("company_name", co['name']).execute()
            
            if existing.data:
                # Update
                supabase.table("companies").update({
                    "ticker_symbol": co['ticker'],
                    "listing_type": "Public",
                    "stock_exchange": co['exchange'],
                    "data_tier": 1
                }).eq("id", existing.data[0]['id']).execute()
                print(f"Updated: {co['name']}")
            else:
                # Insert
                supabase.table("companies").insert({
                    "company_name": co['name'],
                    "ticker_symbol": co['ticker'],
                    "listing_type": "Public",
                    "stock_exchange": co['exchange'],
                    "incorporation_country": "CAN",
                    "data_tier": 1,
                    "primary_sector": "Technology"
                }).execute()
                print(f"Inserted: {co['name']}")
                
        except Exception as e:
            print(f"Error processing {co['name']}: {e}")

if __name__ == "__main__":
    upsert_companies()
