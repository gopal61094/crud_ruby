require 'mysql'
begin 
	con=Mysql.new 'localhost','gopal','gopal123','gopaldb' #Connecting to mysql db

	loop do 
	puts "Select the operation that you want to do the cart table"  
	puts "1.Create"
	puts "2.Read"
	puts "3.Update"
	puts "4.Delete"
	puts "5.exit"
	choice = gets.to_i   #Getting desired input from user and converting into integer

	case choice
	
	when choice=1		#Creating a table if the tables doesn't exist
	puts "Create operation"
	con.query("Create table if not exists cart1(item_id int primary key,item_name varchar(25))")

	when choice=2		#Reading all the contents from the given table
	puts "Read operation"
	rs=con.query 'SELECT * from cart'
	n_rows=rs.num_rows
	n_rows.times do
	puts rs.fetch_row.join()
	end

	when choice=3		#Updating a record in the table
		puts "Update operation"
		puts "enter the id which you want to change"
		ItemId = gets.to_i
		puts "enter the value whcich you want to update"
		Value=gets
		rs1=con.query "update cart set item_name = '#{Value}' where item_id = #{ItemId} "
		puts con.affected_rows

	when choice=4		#Deleting a record from the table
		puts "Delete operation"
		puts "enter the id which you want to delete"
		ItemId = gets.to_i
		rs1=con.query "delete from cart where item_id = #{ItemId} "
		puts con.affected_rows

	else				#Default case 
		puts "Invalid option"
		break
	end

	break if(choice>=5)
	end

rescue Mysql::Error => e  #Rescue block to catch any error
	puts e.errno
	puts e.error
ensure						#Ensure block to close the connection with database
	con.close if con
end