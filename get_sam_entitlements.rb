require 'oci8'
require 'csv'

FICHERO = 'get_entitlments.csv'

# =============================================================================

def cursor_to_array(cursor, use_keys_as_header = false)
  result = []
  while r = cursor.fetch_hash
    result << r.keys if result.empty? && use_keys_as_header
    result << r.values
  end

  puts "Fetched #{result.size - (use_keys_as_header ? 1 : 0)} records"
  result
end

def save_array_to_csv(result, file)
  CSV.new(file, "w") do |csv|
    result.each { |row| csv << row }
  end

  puts "'#{file}' populated with #{result.size} rows"
end
# =============================================================================



def get_entitlements(username, startdate)
 #get the input data of Start date and Username

#generate sql-query
query = "select sam.SAMPROFILEID, sam.USERNAME, ent.SERVICEENTMNTID, ent.STARTDATE, ent.EXPIRYDATE, service.SERVICEENTMNTNAME
from samprofiledata.samprofile sam, samprofiledata.samprofile_service_entmnt ent, samprofiledata.service_entitlement service
where sam.SAMPROFILEID = ent.SAMPROFILEID
and ent.SERVICEENTMNTID = service.SERVICEENTMNTID
and sam.USERNAME like '%#{username.upcase}%'
and ent.STARTDATE > '#{startdate.upcase}'
order by ent.STARTDATE"

#connect to SAM DB
db = 'chisc-idman6t.test.nm.bskyb.com:1523/IDMAN6T'
usern = 'readonly'
pass = 'r3ad0nly'
conn = OCI8.new(usern, pass, db)

#run the query
puts cursor = conn.exec(query)

#save result to a csv file
result = []
result = cursor_to_array(cursor, result.empty?)
save_array_to_csv(result, FICHERO)

#close connection
cursor.close
conn.logoff

end

date = '19-Dec-2011'
name = 'miriam'

get_entitlements(name,date)