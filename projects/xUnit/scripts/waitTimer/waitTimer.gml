// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wait(microsecs){
	microsecs = (microsecs * 1000000);
	var tend = get_timer()+microsecs;
	while(get_timer()<tend)
	{
	    //do nothing
	}
}