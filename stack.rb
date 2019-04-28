module B
 class Stack
  attr_accessor :Outputs
  attr_accessor :Resources
  attr_accessor :AWSTemplateFormatVersion

    def initialize(inputParameters)
      self.AWSTemplateFormatVersion = '2010-09-09'
      self.Outputs = {}
      self.Resources = {}

      self.Outputs['PublicIP'] = Outputs.new.setPublicIPOptions('Description' => "Public IP address of the newly created EC2 instance", 
      'Value' => {'Fn::GetAtt' => ['EC2Instance','PublicIp']})
      
      $i = 1 #Counter 
      while $i <= "#{inputParameters[:instances]}".to_i
	s = "#{$i}".to_s
	f = 'EC2Instance' + s 
        self.Resources["#{f}"] = Resources.new.setEC2InstanceOptions('Properties' => 
        {'ImageId' => "#{inputParameters[:imageid]}",  
        'InstanceType' => "#{inputParameters[:instancetype]}", 
        'SecurityGroups' => [{'Ref' => "InstanceSecurityGroup"}]}, 
        'Type' => "AWS::EC2::Instance")
        $i +=1
      end 

      self.Resources['InstanceSecurityGroup'] = Resources.new.setSecGroupOptions('Properties' => {'GroupDescription' => "Enable SSH access via port 22", 
      'SecurityGroupIngress' => [{'CidrIp' => "#{inputParameters[:allowsshfrom]}",
      'FromPort' => "#{inputParameters[:fromport]}", 
      'IpProtocol' => "#{inputParameters[:ipprotocol]}", 
      'ToPort' => "#{inputParameters[:toport]}"}]},
      'Type' => "AWS::EC2::SecurityGroup")  
    end
  end
end