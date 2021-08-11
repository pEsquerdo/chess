import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    start: Number,
    refreshInterval: Number
  }

  connect() {
    this.load();
  }

  load() {
    if (this.hasRefreshIntervalValue) {
      this.startRefreshing();
    }
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.drawTimer();
    }, this.refreshIntervalValue);
  }

  drawTimer() {
    this.element.innerHTML = this.secondsToTime((Date.now() - this.startValue) / 1000)
  }

  secondsToTime(e) {
    var h = Math.floor(e / 3600).toString().padStart(2, "0"),
        m = Math.floor((e % 3600) / 60).toString().padStart(2, "0"),
        s = Math.floor(e % 60).toString().padStart(2, "0");

    return h + ":" + m + ":" + s
  }
}
