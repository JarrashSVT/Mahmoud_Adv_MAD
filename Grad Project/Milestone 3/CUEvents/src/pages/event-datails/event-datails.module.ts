import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { EventDatailsPage } from './event-datails';

@NgModule({
  declarations: [
    EventDatailsPage,
  ],
  imports: [
    IonicPageModule.forChild(EventDatailsPage),
  ],
})
export class EventDatailsPageModule {}
