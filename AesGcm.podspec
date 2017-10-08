Pod::Spec.new do |s|
  s.name             = 'AesGcm'
  s.version          = '1.0.1'
  s.summary          = 'Galois/Counter Mode (GCM) with Advanced Encryption System (AES).'

  s.description      = <<-DESC
ObjC implementation of Galois/Counter Mode (GCM) with Advanced Encryption System (AES).
                       DESC

  s.homepage         = 'https://github.com/indisoluble/AesGcm'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enrique de la Torre' => 'indisoluble_dev@me.com' }
  s.source           = { :git => 'https://github.com/indisoluble/AesGcm.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '8.3'

  s.source_files = 'AesGcm/Classes/**/*'
  s.public_header_files = 'AesGcm/Classes/*.h'
end
