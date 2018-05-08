import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, PopoverController } from 'ionic-angular';
import { SharePopoverPage } from '../../pages/share-popover/share-popover'
/**
 * Generated class for the EventDatailsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-event-datails',
  templateUrl: 'event-datails.html',
})
export class EventDatailsPage {

  event: any;
  title: string;
  desc: string;

  constructor(public navCtrl: NavController, public navParams: NavParams, public popoverCtrl: PopoverController) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad EventDatailsPage');
    this.event = this.navParams.get('event');
    this.title = this.event.title
    this.desc = this.event.desc
  }

  share(myEvent) {
    let popover = this.popoverCtrl.create(SharePopoverPage, {"event": this.event});
    popover.present({
      ev: myEvent
    });

  }

    
}
