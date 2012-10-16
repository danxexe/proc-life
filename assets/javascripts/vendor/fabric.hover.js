fabric.Canvas.prototype.findTarget = (function(originalFn) {
  return function() {
    var target = originalFn.apply(this, arguments);
    if (target) {
      if (this._hoveredTarget !== target) {
        this.fire('object:over', { target: target });
        if (this._hoveredTarget) {
          this.fire('object:out', { target: this._hoveredTarget });
        }
        this._hoveredTarget = target;
      }
    }
    else if (this._hoveredTarget) {
      this.fire('object:out', { target: this._hoveredTarget });
      this._hoveredTarget = null;
    }
    return target;
  };
})(fabric.Canvas.prototype.findTarget);