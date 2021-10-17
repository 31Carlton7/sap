import 'package:canton_design_system/canton_design_system.dart';
import 'package:ms_undraw/ms_undraw.dart';

class LikedSongsInfoCard extends StatelessWidget {
  const LikedSongsInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: UnDraw(
            height: 150,
            width: 150,
            color: Theme.of(context).primaryColor,
            illustration: UnDrawIllustration.appreciation,
            placeholder: Loading(),
            errorWidget: Container(),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'This is a list of all your liked songs in a playlist!',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      ],
    );
  }
}
