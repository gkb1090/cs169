#!/usr/local/bin/ruby

=begin
Implements attr_accessor_with_history using meta-programming techniques.
Reopens class Class.
=end
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s         # make sure it's a string
    attr_reader attr_name              # create the attribute's getter

    class_eval %Q{
      def #{attr_name}_history
        @#{attr_name}_history = [@#{attr_name}] if @#{attr_name}_history == nil
        @#{attr_name}_history
      end }

    class_eval %Q{
      def #{attr_name}=(val)
        @#{attr_name}_history = [@#{attr_name}] if @#{attr_name}_history == nil
        @#{attr_name}_history << val
        @#{attr_name} = val
      end }
  end
end
