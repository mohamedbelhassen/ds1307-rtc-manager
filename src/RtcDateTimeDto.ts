import { IsNotEmpty } from 'class-validator';

export class RtcDateTimeDto {
  @IsNotEmpty() date: string;
  @IsNotEmpty() time: string;
}
