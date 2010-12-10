# -*- coding: utf-8 -*-
require 'rubygems'
require 'socket'
require 'thread'

sensors = Array.new(8, nil) # センサーの番号と値を入れる配列

t = Thread.new do
  loop do
    sock = TCPSocket.open("127.0.0.1", 20000) # 127.0.0.1(localhost)の20000番へ接続

    ik = sock.read()
    sensor_and_value = ik.slice(/Sensor.*/)
    sensor = sensor_and_value.slice(/\d+/) # センサー番号
    value = /\d*:\s/.match(sensor_and_value).post_match # センサーの値

    sensors[sensor.to_i] = value.to_i

    sensors.each {|sensor|
      print sensor, " | "
    }
    print "\n"

  end
  sock.close # ソケットを閉じる
end

t.join
