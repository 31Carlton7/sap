import 'package:canton_design_system/canton_design_system.dart';

class ArtistViewHeader extends StatelessWidget {
  const ArtistViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CantonBackButton(isClear: true),
      ],
    );
  }
}
