import Component from "@glimmer/component";
import { hash } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import FkControlSelectOption from "./select/option";

export default class FkControlSelect extends Component {
  @action
  handleInput(event) {
    this.args.setValue(event.target.value);
  }

  <template>
    <select
      name={{@name}}
      value={{@value}}
      id={{@fieldId}}
      aria-invalid={{if @invalid "true"}}
      aria-describedby={{if @invalid @errorId}}
      ...attributes
      class="d-form__control-select"
      {{on "input" this.handleInput}}
    >
      {{yield (hash Option=(component FkControlSelectOption selected=@value))}}
    </select>
  </template>
}
