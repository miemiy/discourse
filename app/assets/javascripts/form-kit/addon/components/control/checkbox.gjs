import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import FKLabel from "form-kit/components/label";
import FKMeta from "form-kit/components/meta";
import { eq } from "truth-helpers";

export default class FKControlCheckbox extends Component {
  @action
  handleInput() {
    this.args.setValue(!this.args.value);
  }

  <template>
    {{log @errors}}

    <div class="d-form-field d-form-radio">
      <FKLabel class="d-form__control-radio__label">
        <input
          type="checkbox"
          checked={{eq @value true}}
          class="d-form-radio__input"
          ...attributes
          {{on "change" this.handleInput}}
        />
        {{@label}}
      </FKLabel>

      <FKMeta
        @value={{@value}}
        @field={{@field}}
        @errorId={{@errorId}}
        @errors={{@errors}}
      />
    </div>
  </template>
}
