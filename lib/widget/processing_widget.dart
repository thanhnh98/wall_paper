import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProcessingWidget extends StatefulWidget{

  Widget child, completedIcon;
  Stream<int> processingStream;


  ProcessingWidget({@required this.child, @required this.processingStream, this.completedIcon});

  @override
  State<StatefulWidget> createState() => _ProcessingWidgetState(this.child, this.processingStream, this.completedIcon);

}

class _ProcessingWidgetState extends State<ProcessingWidget>{
  Widget child, completedIcon;
  Stream<int> processingStream;
  _ProcessingWidgetState(
      this.child,
      this.processingStream,
      this.completedIcon,
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: processingStream,
        builder: (context, snapshot){

          if(snapshot == null)
            return child;

          int currentProcessing = snapshot.data;
          if(currentProcessing == null)
            return child;

          if(currentProcessing == 0){
            return CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.green),
            );
          }

          if(currentProcessing == 100){
            return this.completedIcon??SvgPicture.asset("assets/ic_completed.svg");
          }

          print("CURRENT PROCESS $currentProcessing");
          return CircularProgressIndicator(
            value: currentProcessing.toDouble() * 0.01,
            valueColor: new AlwaysStoppedAnimation(Colors.green),
          );
        }
    );
  }

}