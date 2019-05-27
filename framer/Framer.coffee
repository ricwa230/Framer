{_} = require "./Underscore"

Framer = {}

# Root level modules
Framer._ = _
Framer.Utils = (require "./Utils")
Framer.Color = (require "./Color").Color
Framer.Gradient = (require "./Gradient").Gradient
Framer.Layer = (require "./Layer").Layer
Framer._Layer = Framer.Layer # So it won't be overridden by MobileScrollFix
Framer.BackgroundLayer = (require "./BackgroundLayer").BackgroundLayer
Framer.VideoLayer = (require "./VideoLayer").VideoLayer
Framer.SVGLayer = (require "./SVGLayer").SVGLayer
Framer.SVGPath = (require "./SVGPath").SVGPath
Framer.SVGGroup = (require "./SVGGroup").SVGGroup
Framer.TextLayer = (require "./TextLayer").TextLayer
Framer.Events = (require "./Events").Events
Framer.Gestures = (require "./Gestures").Gestures
Framer.Animation = (require "./Animation").Animation
Framer.AnimationGroup = (require "./AnimationGroup").AnimationGroup
Framer.AnimationStateGroup = (require "./AnimationGroup").AnimationStateGroup
Framer.Screen = (require "./Screen").Screen
Framer.Align = (require "./Align").Align
Framer.Blending = (require "./Blending").Blending
Framer.print = (require "./Print").print

# Components
Framer.ScrollComponent = (require "./Components/ScrollComponent").ScrollComponent
Framer.PageComponent = (require "./Components/PageComponent").PageComponent
Framer.SliderComponent = (require "./Components/SliderComponent").SliderComponent
Framer.RangeSliderComponent = (require "./Components/RangeSliderComponent").RangeSliderComponent
Framer.DeviceComponent = (require "./Components/DeviceComponent").DeviceComponent
Framer.GridComponent = (require "./Components/GridComponent").GridComponent
Framer.FlowComponent = (require "./Components/FlowComponent").FlowComponent
Framer.CircularProgressComponent = (require "./Components/CircularProgressComponent").CircularProgressComponent
Framer.MIDIComponent = (require "./Components/MIDIComponent").MIDIComponent
Framer.DeviceView = Framer.DeviceComponent # Compat

_.extend(window, Framer) if window

# Framer level modules
Framer.Context = (require "./Context").Context
Framer.Config = (require "./Config").Config
Framer.EventEmitter = (require "./EventEmitter").EventEmitter
Framer.BaseClass = (require "./BaseClass").BaseClass
Framer.LayerStyle = (require "./LayerStyle").LayerStyle
Framer.AnimationLoop = (require "./AnimationLoop").AnimationLoop
Framer.LinearAnimator = (require "./Animators/LinearAnimator").LinearAnimator
Framer.BezierCurveAnimator = (require "./Animators/BezierCurveAnimator").BezierCurveAnimator
Framer.SpringDHOAnimator = (require "./Animators/SpringDHOAnimator").SpringDHOAnimator
Framer.SpringRK4Animator = (require "./Animators/SpringRK4Animator").SpringRK4Animator
Framer.LayerDraggable = (require "./LayerDraggable").LayerDraggable

Framer.Curves = require "./Animators/Curves"
window.Bezier = Framer.Curves.Bezier
window.Spring = Framer.Curves.Spring

Framer.Importer = (require "./Importer").Importer
Framer.Extras = require "./Extras/Extras"

Framer.GestureInputRecognizer = new (require "./GestureInputRecognizer").GestureInputRecognizer
Framer.Version = require "../build/Version"
Framer.Loop = new Framer.AnimationLoop()

# Metadata
Framer.Info = {}

window.Framer = Framer if window

# Set the defaults
Defaults = (require "./Defaults").Defaults
Defaults.setup()
Framer.resetDefaults = Defaults.reset

# Create the default context, set it to invisble by default so
# the preloader can pick it up if it needs to.
Framer.DefaultContext = new Framer.Context(name: "Default")
Framer.DefaultContext.backgroundColor = "white"
Framer.CurrentContext = Framer.DefaultContext

window.Canvas = new (require "./Canvas").Canvas

Framer.Extras.MobileScrollFix.enable() if Utils.isMobile()
Framer.Extras.TouchEmulator.enable() if not Utils.isTouch()
Framer.Extras.ErrorDisplay.enable() if not Utils.isFramerStudio()
Framer.Extras.Preloader.enable() if not Utils.isFramerStudio()
Framer.Extras.Hints.enable() if not Utils.isFramerStudio()

Utils.domComplete(Framer.Loop.start)

((root, factory) ->
  if typeof define == 'function' and define.amd
    # AMD. Register as an anonymous module.
    define [], factory
  else if typeof module == 'object' and module.exports
    # Node. Does not work with strict CommonJS, but
    # only CommonJS-like environments that support module.exports,
    # like Node.
    module.exports = factory()
  else
    # Browser globals (root is window)
    root.Framer = factory()
  return
) if typeof self != 'undefined' then self else this, ->
  # Just return a value to define the module export.
  # This example returns an object, but the module
  # can return a function as the exported value.
  Framer