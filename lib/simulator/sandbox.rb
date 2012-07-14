module Simulator
  class Sandbox
    def initialize(context)
      @context = context
    end

    def respond_to?(sym)
      puts "Respond to: #{sym}"
      not @context.get(sym.to_sym).nil?
    end

    def method_missing(method_name, *args, &block)
      #should_set = method_name =~ /=/
      #puts "\nMethod: #{method_name}"
      #method_name = method_name.to_s.gsub(/=$/, '').to_sym if should_set
      var = @context.get method_name.to_sym
      #var.value = args.first if should_set
      return var.value unless var.nil?
      super(method_name, *args, &block)
    end
  end
end
