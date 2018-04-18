import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { FirebaseProvider} from '../../providers/firebase/firebase'
import { Observable } from 'rxjs/Observable';

import { HomePage } from '../../pages/home/home'

/**
 * 
 * Generated class for the AddEventsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-add-events',
  templateUrl: 'add-events.html',
})
export class AddEventsPage {

  postForm: FormGroup;
  categories: Observable<any[]>;
  cities: Observable<any[]>;
  audience: Observable<any[]>;
  now:any;
  homePage: any;

  constructor(public navCtrl: NavController, public navParams: NavParams, formBuilder: FormBuilder, public firebaseProvider: FirebaseProvider) {

    this.categories = this.firebaseProvider.getCategories();
    this.audience = this.firebaseProvider.getAudience();
    this.cities = this.firebaseProvider.getCities();
    this.now = new Date().toISOString();
    this.homePage = HomePage;
    
    this.postForm = formBuilder.group({
      title: [
        '',
        Validators.compose([Validators.required])
      ],
      desc: [
        '',
        Validators.compose([Validators.required])
      ],
      startdate: [
        '',
        Validators.compose([Validators.required])
      ],
      enddate: [
        '',
        Validators.compose([Validators.required])
      ],
      starttime: [
        '',
        Validators.compose([Validators.required])
      ],
      endtime: [
        '',
        Validators.compose([Validators.required])
      ],
      address: [
        ''
      ],
      publicorreg: [
        '',
        Validators.compose([Validators.required])
      ],
      catid: [
        '',
        Validators.compose([Validators.required])
      ],
      targetid: [
        '',
        Validators.compose([Validators.required])
      ],
      cityid: [
        '',
        Validators.compose([Validators.required])
      ]
    });
  }

  grow($event){
    $event.target.style.height = $event.target.scrollHeight + "px";
  }
  
  ionViewDidLoad() {
    console.log('ionViewDidLoad AddEventsPage');
  }


  submit()
  {
    this.firebaseProvider.addEvent(this.postForm.value)
  }
  

}
