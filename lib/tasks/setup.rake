require 'csv'

namespace :setup do
  # All rake tasks will be stored in this file
  desc "Setup app"
  task :start => :environment do
    # This task runs all tasks necessary to the app
    puts "Setting up app - Get comfy this may take a while"

    # 1st clear all databases
    Rake::Task["setup:empty"].execute

    # 2nd addsellers
    puts "Adding pre-defined Sellers"
    Rake::Task["setup:addsellers"].execute

    # 3rd addproducts
    puts "Adding pre-defined Products"
    Rake::Task["setup:addproducts"].execute

    # 4th addadmin
    puts "Adding Super Admin account"
    Rake::Task["setup:addadmin"].execute

    # 5th addcoords
    puts "Adding co-ordinates to Sellers"
    Rake::Task["setup:addcoords"].execute
  end

  desc "Add pre-defined sellers"
  task addsellers: :environment do

    File.open("lib/assets/sellerPasswords.csv", "w") do |line|
      line.puts "Seller, Password \n"

      CSV.foreach("lib/assets/SellersToBeParsed.csv", :headers => true) do |row|
        puts row.inspect

        # Generate random password length
        length = rand(6..12)

        # Choose a random character for each iteration of the loop
        randomPassword = ""

        for i in (1..length)
          randomPassword << rand(48..125).chr
        end

        puts "PASSWORD #{randomPassword}"

        line.puts row[0].to_s + ',' + randomPassword + "\n"

        begin
          Seller.create!(
              name: row[0].to_s,
              longitude: row[1].to_f,
              latitude: row[2].to_f,
              address: row[3].to_s,
              password: randomPassword
          )
        rescue ActiveRecord::RecordNotUnique

        end

      end
    end
  end

  desc "Add pre-defined products"
  task addproducts: :environment do

    CSV.foreach("lib/assets/FINALDATASET.csv", :headers => true) do |row|

      productSeller = Seller.find_by(name: row[3].to_s)
      if productSeller.nil?

        # Generate random password length
        length = rand(6..12)

        # Choose a random character for each iteration of the loop
        randomPassword = ""

        for i in (1..length)
          randomPassword << rand(48..125).chr
        end

        productSeller = Seller.find_by(name: row[3].to_s)

        begin
          Seller.create!(
              name: row[0].to_s,
              longitude: row[1].to_f,
              latitude: row[2].to_f,
              address: row[3].to_s,
              password: randomPassword
          )

        rescue ActiveRecord::RecordNotUnique
          puts "DID NOT ADD"
        end
      end

      randomCost = rand(20..250) + rand().round(2)

      begin
        Product.create!(
            substancename: row[0].to_s,
            nonproprietaryname: row[1].to_s,
            propname: row[2].to_s,
            producttype: row[4].to_s,
            dosageform: row[5].to_s,
            routename: row[6].to_s,
            marketingcategory: row[7].to_s,
            activenumerator: row[8].to_i,
            activeingredunit: row[9].to_s,
            price: randomCost.to_f,
            #############################
            # Find seller name and then store the ID
            seller_id: productSeller.id
        )
      rescue
      end

    end
  end

  desc "Add Super Admin account"
  task addadmin: :environment do
    User.create!(
        name: "admin",
        email: "admin@admin.com",
        password: "admin123",
        admin: true
    )
  end

  desc "Add co-ordinages to Sellers"
  task addcoords: :environment do
    allSellers = Seller.all
    longitude = 45.98
    latitude = 56.89

    addresses = ["2217 College", "407 Sharp St.", "1119 Market St.", "133 East Main", "617 Sycamore", "726 Creek Top", "202 4th North", "618 Rossville Road"]

    allSellers.each do |seller|

      seller.update_columns(longitude: longitude)
      seller.update_columns(latitude: latitude)
      randomAddress = addresses[rand(0..8)]
      seller.update_columns(address: randomAddress)
    end

  end

  task :empty => :environment do
    # Empty all the databases
    puts "Removing Products"
    Product.destroy_all
    puts "Clearing Carts"
    Cart.destroy_all
    puts "Wiping LineItems"
    LineItem.destroy_all
    puts "Resetting Users"
    User.destroy_all
    puts "Deleting Sellers"
    Seller.destroy_all
  end
end