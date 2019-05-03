require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
   "#{self.to_s.downcase}s"
  end

  def self.column_names
    sql = "pragma table_info('#{self.table_name}')"
    table_info = DB[:conn].execute(sql)
    table_info.collect do |item|
      item["name"]
    end
  end

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    self.class.column_names.delete_if{|item| item=="id"}.join(", ")
  end

  def values_for_insert
    "#{self.name.to_s}, #{self.grade.to_s}"
  end
end



#require_relative './lib/student.rb'
