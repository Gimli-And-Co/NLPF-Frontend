<template>
  <v-form v-model="valid">
    <v-container>
      <v-row>
        <v-col cols="12">
          <v-select
            v-model="departementInput"
            :items="filterDepartements"
            :item-text="(e) => `${e.code} - ${e.nom}`"
            item-value="code"
            label="Départements"
            required
            outlined
            @change="fetchCommunes"
          >
            <template v-slot:prepend-item>
              <v-list-item>
                <v-list-item-action>
                  <v-icon> mdi-text-search </v-icon>
                </v-list-item-action>
                <v-list-item-content class="py-0">
                  <v-text-field
                    v-model="departementFilterInput"
                    label="Recherche"
                    hide-hints
                  >
                  </v-text-field>
                </v-list-item-content>
              </v-list-item>
              <v-divider class="mt-2"></v-divider>
            </template>
          </v-select>
        </v-col>

        <v-col cols="12">
          <div class="mb-2">Il y a {{ communesList.length }} communes.</div>
          <v-select
            :disabled="communesList.length == 0"
            v-model="communeInput"
            label="Communes"
            :items="filterCommunes"
            :item-text="(e) => `${e.properties.code} - ${e.properties.nom}`"
            item-value="properties.code"
            :loading="communeLoading"
            required
            outlined
          >
            <template v-slot:prepend-item>
              <v-list-item>
                <v-list-item-action>
                  <v-icon> mdi-text-search </v-icon>
                </v-list-item-action>
                <v-list-item-content class="py-0">
                  <v-text-field
                    v-model="communeFilterInput"
                    label="Recherche"
                    hide-hints
                  >
                  </v-text-field>
                </v-list-item-content>
              </v-list-item>
              <v-divider class="mt-2"></v-divider>
            </template>
          </v-select>
        </v-col>
        <!-- <v-col cols="12">
          <div class="font-weight-bold">Montant de la vente (en K€)</div></v-col
        >
        <v-col cols="12" class="mt-4">
          <v-range-slider
            v-model="range"
            :max="max"
            :min="min"
            hide-details
            step="1"
            class="align-center"
            thumb-color="primary"
            thumb-label="always"
            :thumb-size="34"
          >
          </v-range-slider>
        </v-col>
        <v-col cols="12">
          <v-row>
            <v-col class="center">
              <v-text-field
                outlined
                :value="range[0]"
                class="mt-0 pt-0"
                hide-details
                single-line
                type="number"
                style="width: 60px"
                @change="$set(range, 0, $event)"
              ></v-text-field>
            </v-col>
            <v-col class="center">
              <v-text-field
                outlined
                :value="range[1]"
                class="mt-0 pt-0"
                hide-details
                single-line
                type="number"
                style="width: 60px"
                @change="$set(range, 1, $event)"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-col> -->
        <!-- <v-col cols="12">
          <v-btn
            :loading="loading"
            color="primary"
            block
            outlined
            @click="filter"
            :disabled="!valid"
          >
            Recherche
          </v-btn>
        </v-col> -->
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
export default {
  props: {
    departementList: Array,
    communesList: Array,
    price_range: Array,
    loading: Boolean,
  },
  data: () => ({
    valid: false,
    departementInput: "",
    departementFilterInput: "",
    communeInput: "",
    communeLoading: false,
    communeFilterInput: "",
    min: 0,
    max: 10000,
    range: [0, 10000],
  }),
  methods: {
    filter() {
      this.$emit("filter", {
        departementInput: this.departementInput,
        communeInput: this.communeInput,
        price_range: this.range.map((e) => e * 1000),
      });
    },
    fetchCommunes() {
      this.communeLoading = true;
      this.$emit("fetchCommunes", { input: this.departementInput });
    },
    setDepartementInput(input) {
      this.departementInput = input;
    },
    setCommuneInput(input) {
      this.communeInput = input;
    },
  },
  computed: {
    filterCommunes() {
      return this.communesList.filter((e) => {
        if (this.communeFilterInput.length === 0) {
          return true;
        } else {
          const str = e.properties.code + e.properties.nom.toLowerCase();
          return str.includes(this.communeFilterInput);
        }
      });
    },
    filterDepartements() {
      return this.departementList.filter((e) => {
        if (this.departementFilterInput.length === 0) {
          return true;
        } else {
          const str = e.code + e.nom.toLowerCase();
          return str.includes(this.departementFilterInput);
        }
      });
    },
  },
  watch: {
    communesList(newList, old) {
      this.communeLoading = false;
    },
    price_range(newList, old) {
      this.range = newList;
    },
  },
};
</script>

<style>
</style>