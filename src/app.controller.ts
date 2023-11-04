/*import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}*/
import { Get, Controller, Render, Post, Res } from '@nestjs/common';
import { Body } from '@nestjs/common';
import { RtcDateTimeDto } from './RtcDateTimeDto';
import { Response } from 'express';

// import {Body, Controller, Get, Post, Redirect, Req, Res, UsePipes, ValidationPipe } from '@nestjs/common';
//import { Response } from 'express';
//import { join } from 'path';
import * as shell from 'shelljs';

const piUserHomeFolderPath = '/home/pi/';
//const rtcManagerPath = piUserHomeFolderPath + 'raspberry-pi-rtc-management-web-app/';
const rtcManagerPath = piUserHomeFolderPath + 'ds1307-rtc-manager/';
// import * as shell from 'shelljs';
@Controller()
export class AppController {
  @Get()
  @Render('index')
  root() {
    const currentDate = new Date();
    return { date: currentDate.toLocaleDateString('en-CA') };
  }

  @Post()
  setTime(@Body() dateTimeDto: RtcDateTimeDto, @Res() res: Response) {
    /*if ( shell.exec(rtcManagerPath+"write_to_pipe.sh '"+str+"'").code !== 0) {
      //shell.echo('Error: execution of pipe controller failed');
      shell.exit(1);
    }*/
    const time = dateTimeDto.time.replace(':', ' ');
    const date = dateTimeDto.date.replaceAll('-', ' ');

    const time_command = "sudo " + rtcManagerPath + "set_time.sh '" + time + "'";
    const date_command = "sudo " + rtcManagerPath + "set_date.sh '" + date + "'";

    const error = {
      time: null,
      date: null,
    };
    const success = {
      time: null,
      date: null,
    };
    

    if (shell.exec(time_command).code !== 0) {
      //shell.echo('Error: execution of pipe controller failed');
      error.time = 'Error occured when setting time';
      shell.exit(1);
    }else{
      success.time = 'Time is well set';

    }

    if (shell.exec(date_command).code !== 0) {
      //shell.echo('Error: execution of pipe controller failed');
      error.date = 'Error occured when setting date';
      shell.exit(1);
    }else{
      success.date = 'Date is well set';

    }
    //error.date = 'Error occured when setting time';
    const currentDate = new Date();
    return res.render('index.hbs', { error: error, 
      success:success,
      date: currentDate.toLocaleDateString('en-CA') });
  }

  @Post('restart')
  @Render('index')
  restart() {
    shell.exec('sudo reboot');
    return {};
  } 

  @Post('fan_test')
  @Render('index')
  test_sytem_fan() {
    shell.exec('/usr/bin/python ' + rtcManagerPath + 'alluler_ventilo.py');
    return {};
  }

}
