# connect to the DSN
require 'DBI'

class Database
  cnxn = DBI.connect('DBI:ODBC:CData PostgreSQL Source', '', '')

  # execute a SELECT query and store the result set
  result_set = cnxn.execute('SELECT ShipName, ShipCity FROM Orders')

  # display the names of the columns
  result_set.column_names.each do |name|
    print name, "\t"
  end
  puts

  # display the results
  while (row = result_set.fetch)
    (0..result_set.column_names.size - 1).each do |n|
      print row[n], "\t"
    end
    puts
  end
  result_set.finish

  # close the connection
  cnxn&.disconnect
end
