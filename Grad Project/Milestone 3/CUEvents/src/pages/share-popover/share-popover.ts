import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

/**
 * Generated class for the SharePopoverPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  template: `
    <ion-list style="direction: rtl">
      <div ion-item (click)="shareEvent('wa')">
        <img src="assets/imgs/whatsapp.png" width="35" height="35"/>
        <span style="margin-right: 10px;">WhatsApp</span>
      </div>
      <div ion-item (click)="shareEvent('ig')">
        <img src="assets/imgs/socialig.png" width="35" height="35"/>
        <span style="margin-right: 10px">   Instagram  </span>
      </div>
      <div ion-item (click)="shareEvent('fb')">
        <img src="assets/imgs/socialfb.png" width="35" height="35"/>
        <span style="margin-right: 10px">  Facebook </span>
      </div>
      <div ion-item (click)="shareEvent('tw')">
        <img src="assets/imgs/socialtwitter.png" width="35" height="35"/>
        <span style="margin-right: 10px">  Twitter </span>
      </div>
    </ion-list>
  `
})
export class SharePopoverPage {

  constructor(public navCtrl: NavController, public navParams: NavParams) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad SharePopoverPage');
  }

}
