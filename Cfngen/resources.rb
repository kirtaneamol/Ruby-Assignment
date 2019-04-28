module A
  class Resources
    attr_accessor :EC2Instance
    attr_accessor :InstanceSecurityGroup
    #Default constructor
    def initialize()
      self.EC2Instance = {}
      self.InstanceSecurityGroup = {}
    end
    #Set EC2 Instance options
    def setEC2InstanceOptions(options = {})
      self.EC2Instance = options
    end
    #Set Security group options
    def setSecGroupOptions(options = {})
      self.InstanceSecurityGroup = options
    end
  end

  class Outputs 
  attr_accessor :PublicIP
    #Default constructor
    def initialize()
      self.PublicIP = {}
    end
    #Set Output attribute options
    def setPublicIPOptions(options = {})
      self.PublicIP = options
    end
  end
end