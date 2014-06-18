require 'spec_helper'

describe 'tp::conf', :type => :define do

  let :title do
    'redis::redis.conf'
  end
  context 'with default parameters' do
    it do
      should contain_file('tp_conf_/etc/redis/redis.conf').only_with({
        'ensure'  => 'present',
        'path'    => '/etc/redis/redis.conf',
        'mode'    => '0644',
        'owner'   => 'root',
        'group'   => 'root',
        'notify'  => 'Service[redis]',
      })
    end
  end


  context 'with default parameters on test osfamily' do
    let(:facts) {
      {
        :osfamily => 'test',
      } 
    }
    it do
      should contain_file('tp_conf_/etc/redis-test/redis.conf').only_with({
        'ensure'  => 'present',
        'path'    => '/etc/redis-test/redis.conf',
        'mode'    => '0644',
        'owner'   => 'test',
        'group'   => 'test',
        'notify'  => 'Service[redis-test]',
      })
    end
  end


  context 'with default parameters on testos operatingsystem' do
    let(:facts) {
      {
        :osfamily => 'test',
        :operatingsystem => 'testos',
      } 
    }
    it do
      should contain_file('tp_conf_/etc/redis-testos/redis.conf').only_with({
        'ensure'  => 'present',
        'path'    => '/etc/redis-testos/redis.conf',
        'mode'    => '0644',
        'owner'   => 'test',
        'group'   => 'test',
        'notify'  => 'Service[redis-testos]',
      })
    end
  end


  context 'with default parameters on testos 0.0.1 operatingsystem' do
    let(:facts) {
      {
        :osfamily => 'test',
        :operatingsystem => 'testos',
        :operatingsystemrelease => '0.0.1',
      } 
    }
    it do
      should contain_file('tp_conf_/etc/redis-testos001/redis.conf').only_with({
        'ensure'  => 'present',
        'path'    => '/etc/redis-testos001/redis.conf',
        'mode'    => '0644',
        'owner'   => 'test',
        'group'   => 'test',
        'notify'  => 'Service[redis-testos001]',
      })
    end
  end


  context 'with custom parameters' do
    let(:params) {
      {
        'source' => 'puppet:///modules/site/redis/redis.conf',
        'path'   => '/opt/etc/redis/redis.conf',
        'mode'   => '0777',
        'owner'  => 'mytest',
        'group'  => 'mytest',
      }
    }
    it do
      should contain_file('tp_conf_/opt/etc/redis/redis.conf').only_with({
        'ensure'  => 'present',                           
        'path'    => '/opt/etc/redis/redis.conf',             
        'source'  => 'puppet:///modules/site/redis/redis.conf',
        'mode'    => '0777',                              
        'owner'   => 'mytest',
        'group'   => 'mytest',                              
        'notify'  => 'Service[redis]',                    
      })                                                  
    end                                                   
  end 


  context 'with custom parameters on testos 0.0.1 operatingsystem' do
    let(:facts) {
      {
        :osfamily => 'test',
        :operatingsystem => 'testos',
        :operatingsystemrelease => '0.0.1',
      } 
    }
    let(:params) {
      { 
        'source' => 'puppet:///modules/site/redis/redis.conf',
        'mode'   => '0777',
        'owner'  => 'mytest',
        'group'  => 'mytest',
      }
    }
    it do
      should contain_file('tp_conf_/etc/redis-testos001/redis.conf').only_with({
        'ensure'  => 'present',
        'path'    => '/etc/redis-testos001/redis.conf',
        'source'  => 'puppet:///modules/site/redis/redis.conf',
        'mode'    => '0777',                              
        'owner'   => 'mytest',
        'group'   => 'mytest',                              
        'notify'  => 'Service[redis-testos001]',
      })
    end
  end


  context 'with custom content (and *ignored* template, source and epp params)' do
    let(:params) {
      {
        'content'      => "custom content",
        'epp'          => 'tp/spec/spec.epp',
        'template'     => 'tp/spec/spec.erb',
        'source'       => 'puppet:///modules/site/redis/redis.conf',
      }
    }
    it do 
      should contain_file('tp_conf_/etc/redis/redis.conf').with({
        'ensure'  => 'present',                           
        'path'    => '/etc/redis/redis.conf',             
        'content' => 'custom content',
      })                                                  
    end                                                   
  end 


  context 'with custom erb template and options_hash' do
    let(:params) {
      {
        'template'     => 'tp/spec/spec.erb',
        'options_hash' => { 
          'key_a'  => 'value_a',
          'key_b'  => 'value_b',
        },
      }
    }
    it do 
      should contain_file('tp_conf_/etc/redis/redis.conf').with({
        'ensure'  => 'present',                           
        'path'    => '/etc/redis/redis.conf',             
        'content' => "key_a = value_a ; key_b = value_b\n",
      })                                                  
    end                                                   
  end 


  pending 'with custom epp template and options_hash' do
    let(:params) {
      {
        'epp'          => 'tp/spec/spec.epp',
        'options_hash' => { 
          'key_a'  => 'value_a',
          'key_b'  => 'value_b',
        },
      }
    }
    it do 
      should contain_file('tp_conf_/etc/redis/redis.conf').with({
        'ensure'  => 'present',                           
        'path'    => '/etc/redis/redis.conf',             
        'content' => "key_a = value_a ; key_b = value_b\n",
      })                                                  
    end                                                   
  end 

end