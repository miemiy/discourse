import Component from "@glimmer/component";
import { hash } from "@ember/helper";
import { action } from "@ember/object";
import willDestroy from "@ember/render-modifiers/modifiers/will-destroy";
import IconPicker from "select-kit/components/icon-picker";

export default class FkControlIconSelector extends Component {
  @action
  handleInput(value) {
    this.args.setValue(value);
  }

  @action
  handleDestroy() {
    this.args.setValue(undefined);
  }

  <template>
    <IconPicker
      @value={{@value}}
      @options={{hash maximum=1}}
      @onChange={{this.handleInput}}
      {{willDestroy this.handleDestroy}}
    />
  </template>
}
