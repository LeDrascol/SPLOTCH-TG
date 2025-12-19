import {
  Feature,
  FeatureColorInput,
  FeatureChoiced,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const quirk_cosglow_color: Feature<string> = {
  name: 'Glow Color',
  description: 'The initial color of your glow effect.',
  component: FeatureColorInput,
};

export const quirk_cosglow_thickness: FeatureChoiced = {
  name: 'Glow Thickness',
  description: 'The initial outline thickness and light intensity.',
  component: FeatureDropdownInput,
};
