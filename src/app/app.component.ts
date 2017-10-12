import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  year = (new Date()).getFullYear();
  videos = [
    {
      display_name: "She Sells Sanctuary",
      source: "https://www.youtube.com/embed/KrrygLU3deg"
    },
    {
      display_name: "Seven Nation Army",
      source: "https://www.youtube.com/embed/1YEbAHIl8TQ"
    },
    {
      display_name: "Reptilia",
      source: "https://www.youtube.com/embed/xMU5MHd18Z0"
    },
    {
      display_name: "Are You Gonna Be My Girl?",
      source: "https://www.youtube.com/embed/qj4Ybiua2RI"
    },
    {
      display_name: "Here I Go Again",
      source: "https://www.youtube.com/embed/kZnaUkkvfrk"
    },
    {
      display_name: "Joker And The Thief",
      source: "https://www.youtube.com/embed/nZ-TC8A9lw4"
    },
    {
      display_name: "Home Again",
      source: "https://www.youtube.com/embed/uWwWJJ8UZjM"
    },
    {
      display_name: "Whisky In The Jar",
      source: "https://www.youtube.com/embed/E9NtAjsMCs0"
    },
  ];
}