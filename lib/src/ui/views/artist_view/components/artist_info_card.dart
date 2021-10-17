import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/artist.dart';

class ArtistInfoCard extends StatelessWidget {
  const ArtistInfoCard(this.artist);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Theme.of(context).colorScheme.onSecondary,
        child: Container(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fans',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    CantonMethods.separateNumberByThreeDigits(source: artist.numFans!),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
