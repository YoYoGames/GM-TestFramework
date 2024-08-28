/// @description Insert description here
// You can write your code in this editor

buffer_seek(network_buffer, buffer_seek_start, 0);
buffer_write(network_buffer, buffer_string, "Finished test execution!");
network_send_raw(socket, network_buffer, buffer_tell(network_buffer));

