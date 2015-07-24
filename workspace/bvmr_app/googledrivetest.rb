require "google/api_client"
require "google_drive"
require 'roo'

# Authorizes with OAuth and gets an access token.
client = Google::APIClient.new
auth = client.authorization
auth.client_id = "247013468821-4sr243vkngrt5ingp3pqdt2q0gvbqu3j.apps.googleusercontent.com"
auth.client_secret = "ARJrQuDVbm6ZoenGcgrtC0qi"
auth.scope = [
  "https://www.googleapis.com/auth/drive",
  "https://spreadsheets.google.com/feeds/"
]
# auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
auth.redirect_uri = "https://www.example.com/oauth2callback"
print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
print("2. Enter the authorization code shown in the page: ")
auth.code = $stdin.gets.chomp
auth.fetch_access_token!
access_token = auth.access_token

# Creates a session.
session = GoogleDrive.login_with_oauth(access_token)

# Gets list of remote files.
session.files.each do |file|
  p file.title
end

# Downloads to a local file.
file = session.file_by_title("testreport.xls")
file.download_to_file("public/tmp/testreport.xls")
var_file="public/tmp/testreport.xls"

ex = Roo::Excel.new(var_file)
    # ex.default_sheet = ex.sheets[0] #Mention the sheet number
    ex.default_sheet = ex.sheets[0]
    (2..ex.last_row).each do |line| #start and end of row
    od = ex.cell(line,'C')
    sale = ex.cell(line,'F')         

    sample = Sample.create(:order_date => od,:sales => sale)
end
