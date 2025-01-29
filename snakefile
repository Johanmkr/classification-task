# the comma is there because glob_wildcards returns a named tuple
numbers, = glob_wildcards("data/train_{number}.csv")


# rule that collects the target files
rule all:
    input:
        expand("results/chart_{number}.svg", number=numbers)


rule chart:
    input:
        script="plot_results.py",
        predictions="results/predictions_{number}.csv",
        training="data/train_{number}.csv"
    output:
        "results/chart_{number}.svg"
    log:
        "logs/chart_{number}.txt"
    shell:
        """
        python {input.script} --training-data {input.training} --predictions {input.predictions} --output-chart {output}
        """


rule predictions:
    input:
        script="generate_predictions.py",
        training="data/train_{number}.csv",
        test="data/test_{number}.csv"
    output:
        "results/predictions_{number}.csv"
    log:
        "logs/predictions_{number}.txt"
    shell:
        """
        python {input.script} --num-neighbors 7 --training-data {input.training} --test-data {input.test} --predictions {output}
        """
