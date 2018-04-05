import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { Observable } from 'rxjs/Observable';
// import { AngularFireDatabase } from 'angularfire2/database'
import { FirebaseProvider} from '../../providers/firebase/firebase'

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  events: Observable<any[]>;
  categories: Observable<any[]>;
  newEvent: any;

  constructor(public navCtrl: NavController, public firebaseProvider: FirebaseProvider)
  {
    console.log('constructor')
    //this.events = db.list('events').valueChanges();
    this.events = this.firebaseProvider.getEvents();
    this.categories = this.firebaseProvider.getCategories();
  }

  addEvent()
  {
    this.firebaseProvider.addEvent(this.newEvent)
  }

}
